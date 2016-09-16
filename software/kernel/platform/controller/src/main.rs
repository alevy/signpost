#![crate_name = "storm"]
#![no_std]
#![no_main]
#![feature(const_fn,lang_items)]

#[macro_use(static_init)]
extern crate common;
extern crate cortexm4;
extern crate drivers;
extern crate hil;
extern crate main;
extern crate sam4l;
extern crate support;

extern crate signpost_drivers;
extern crate signpost_hil;

use drivers::console::{self, Console};
// use drivers::nrf51822_serialization::{self, Nrf51822Serialization};
use drivers::timer::TimerDriver;
use drivers::virtual_alarm::{MuxAlarm, VirtualMuxAlarm};
use drivers::virtual_i2c::I2CDevice;
use drivers::virtual_i2c::MuxI2C;
use hil::Controller;
use hil::spi_master::SpiMaster;
use main::{Chip, MPU, Platform};
use sam4l::usart;

use common::take_cell::TakeCell;

#[macro_use]
pub mod io;

// // HAL unit tests. To enable a particular unit test, uncomment the call to
// // start the test in the init function below.
// #[allow(dead_code)]
// mod gpio_dummy;
// #[allow(dead_code)]
// mod spi_dummy;
// #[allow(dead_code)]
// mod i2c_dummy;
// #[allow(dead_code)]
// mod flash_dummy;

static mut spi_read_buf: [u8; 64] = [0; 64];
static mut spi_write_buf: [u8; 64] = [0; 64];

unsafe fn load_processes() -> &'static mut [Option<main::process::Process<'static>>] {
    extern "C" {
        /// Beginning of the ROM region containing app images.
        static _sapps: u8;
    }

    const NUM_PROCS: usize = 2;

    #[link_section = ".app_memory"]
    static mut MEMORIES: [[u8; 8192]; NUM_PROCS] = [[0; 8192]; NUM_PROCS];

    static mut processes: [Option<main::process::Process<'static>>; NUM_PROCS] = [None, None];

    let mut addr = &_sapps as *const u8;
    for i in 0..NUM_PROCS {
        // The first member of the LoadInfo header contains the total size of each process image. A
        // sentinel value of 0 (invalid because it's smaller than the header itself) is used to
        // mark the end of the list of processes.
        let total_size = *(addr as *const usize);
        if total_size == 0 {
            break;
        }

        let process = &mut processes[i];
        let memory = &mut MEMORIES[i];
        *process = Some(main::process::Process::create(addr, total_size, memory));
        // TODO: panic if loading failed?

        addr = addr.offset(total_size as isize);
    }

    if *(addr as *const usize) != 0 {
        panic!("Exceeded maximum NUM_PROCS.");
    }

    &mut processes
}

struct SignpostController {
    console: &'static Console<'static, usart::USART>,
    gpio: &'static drivers::gpio::GPIO<'static, sam4l::gpio::GPIOPin>,
    timer: &'static TimerDriver<'static, VirtualMuxAlarm<'static, sam4l::ast::Ast>>,
    // spi: &'static drivers::spi::Spi<'static, sam4l::spi::Spi>,
    gpio_async: &'static signpost_drivers::gpio_async::GPIOAsync<'static, signpost_drivers::mcp23008::MCP23008<'static>>,
    coulomb_counter_i2c_selector: &'static signpost_drivers::i2c_selector::I2CSelector<'static, signpost_drivers::pca9544a::PCA9544A<'static>>,
    coulomb_counter_generic: &'static signpost_drivers::ltc2941::LTC2941Driver<'static>,
}

impl Platform for SignpostController {
    // fn mpu(&mut self) -> &mut cortexm4::mpu::MPU {
    // &mut self.chip.mpu
    // }

    fn with_driver<F, R>(&mut self, driver_num: usize, f: F) -> R
        where F: FnOnce(Option<&main::Driver>) -> R
    {

        match driver_num {
            0 => f(Some(self.console)),
            1 => f(Some(self.gpio)),
            3 => f(Some(self.timer)),
            // 4 => f(Some(self.spi)),
            100 => f(Some(self.gpio_async)),
            101 => f(Some(self.coulomb_counter_i2c_selector)),
            102 => f(Some(self.coulomb_counter_generic)),
            _ => f(None)
        }
    }
}


unsafe fn set_pin_primary_functions() {
    use sam4l::gpio::{PA, PB, PC};
    use sam4l::gpio::PeripheralFunction::{A, B, C, D, E};

    // Configuring pins for RF233
    // SPI
    PC[03].configure(Some(A)); // SPI NPCS0
    PC[02].configure(Some(A)); // SPI NPCS1
    PC[00].configure(Some(A)); // SPI NPCS2
    PC[01].configure(Some(A)); // SPI NPCS3 (RF233)
    PC[06].configure(Some(A)); // SPI CLK
    // PC[04].configure(Some(A)); // SPI MISO
    PC[04].configure(None); // SPI MISO
    PC[05].configure(Some(A)); // SPI MOSI
    // GIRQ line of RF233
    PA[20].enable();
    PA[20].disable_output();
    PA[20].disable_interrupt();
    // PA00 is RCLK
    // PC14 is RSLP
    // PC15 is RRST
    PC[14].enable();
    // PC[14].disable_output();
    PC[14].clear();
    PC[14].enable_output();
    PC[14].clear();




    PC[15].enable();
    // PC[15].disable_output();
    PC[15].set();
    PC[15].enable_output();
    PC[15].set();

    // Right column: Firestorm pin name
    // Left  column: SAM4L peripheral function
    // LI_INT   --  EIC EXTINT2
    PA[04].configure(Some(C));

    // EXTINT1  --  EIC EXTINT1
    PA[06].configure(Some(C));

    // PWM 0    --  GPIO pin
    PA[08].configure(None);

    // PWM 1    --  GPIO pin
    PC[16].configure(None);

    // PWM 2    --  GPIO pin
    PC[17].configure(None);

    // PWM 3    --  GPIO pin
    PC[18].configure(None);

    // AD5      --  ADCIFE AD1
    PA[05].configure(Some(A));

    // AD4      --  ADCIFE AD2
    PA[07].configure(Some(A));

    // AD3      --  ADCIFE AD3
    PB[02].configure(Some(A));

    // AD2      --  ADCIFE AD4
    PB[03].configure(Some(A));

    // AD1      --  ADCIFE AD5
    PB[04].configure(Some(A));

    // AD0      --  ADCIFE AD6
    // PB[05].configure(Some(A));
    PB[05].configure(None);
    PB[05].enable();
    // PC[14].disable_output();
    PB[05].disable_output();
    PB[05].disable_pull_up();
    PB[05].disable_pull_down();




    // BL_SEL   --  USART3 RTS
    PB[06].configure(Some(A));
    //          --  USART3 CTS
    PB[07].configure(Some(A));
    //          --  USART3 CLK
    PB[08].configure(Some(A));
    // PRI_RX   --  USART3 RX
    PB[09].configure(Some(A));
    // PRI_TX   --  USART3 TX
    PB[10].configure(Some(A));
    // U1_CTS   --  USART0 CTS
    PB[11].configure(Some(A));
    // U1_RTS   --  USART0 RTS
    PB[12].configure(Some(A));
    // U1_CLK   --  USART0 CLK
    PB[13].configure(Some(A));
    // U1_RX    --  USART0 RX
    // PB[14].configure(Some(A));
    PB[14].configure(Some(B));



    // U1_TX    --  USART0 TX
    PB[15].configure(Some(A));
    // STORMRTS --  USART2 RTS
    PC[07].configure(Some(B));
    // STORMCTS --  USART2 CTS
    PC[08].configure(Some(E));
    // STORMRX  --  USART2 RX
    PC[11].configure(Some(B));
    // STORMTX  --  USART2 TX
    PC[12].configure(Some(B));
    // STORMCLK --  USART2 CLK
    PA[18].configure(Some(A));

    // ESDA     --  TWIMS1 TWD
    PB[00].configure(Some(A));

    // ESCL     --  TWIMS1 TWCK
    PB[01].configure(Some(A));

    // SDA      --  TWIM2 TWD
    PA[21].configure(Some(E));

    // SCL      --  TWIM2 TWCK
    PA[22].configure(Some(E));

    // EPCLK    --  USBC DM
    PA[25].configure(Some(A));

    // EPDAT    --  USBC DP
    PA[26].configure(Some(A));

    // PCLK     --  PARC PCCK
    PC[21].configure(Some(D));
    // PCEN1    --  PARC PCEN1
    PC[22].configure(Some(D));
    // EPGP     --  PARC PCEN2
    PC[23].configure(Some(D));
    // PCD0     --  PARC PCDATA0
    PC[24].configure(Some(D));
    // PCD1     --  PARC PCDATA1
    PC[25].configure(Some(D));
    // PCD2     --  PARC PCDATA2
    PC[26].configure(Some(D));
    // PCD3     --  PARC PCDATA3
    PC[27].configure(Some(D));
    // PCD4     --  PARC PCDATA4
    // PC[28].configure(Some(D));
    // PC[28].configure(Some(B));  // temp MISO
    PC[28].configure(None);  // temp MISO
    PC[28].enable();
    // PC[14].disable_output();
    PC[28].disable_output();
    PC[28].disable_pull_up();
    PC[28].disable_pull_down();


    // PCD5     --  PARC PCDATA5
    PC[29].configure(Some(D));
    // PCD6     --  PARC PCDATA6
    PC[30].configure(Some(D));
    // PCD7     --  PARC PCDATA7
    PC[31].configure(Some(D));

    // P2       -- GPIO Pin
    PA[16].configure(None);
    // P3       -- GPIO Pin
    PA[12].configure(None);
    // P4       -- GPIO Pin
    PC[09].configure(None);
    // P5       -- GPIO Pin
    PA[10].configure(None);
    // P6       -- GPIO Pin
    PA[11].configure(None);
    // P7       -- GPIO Pin
    PA[19].configure(None);
    // P8       -- GPIO Pin
    PA[13].configure(None);

    // none     -- GPIO Pin
    PA[14].configure(None);

    // ACC_INT2 -- GPIO Pin
    PC[20].configure(None);
    // STORMINT -- GPIO Pin
    PA[17].configure(None);
    // TMP_DRDY -- GPIO Pin
    PA[09].configure(None);
    // ACC_INT1 -- GPIO Pin
    PC[13].configure(None);
    // ENSEN    -- GPIO Pin
    PC[19].configure(None);
    // LED0     -- GPIO Pin
    PC[10].configure(None);
}

#[no_mangle]
pub unsafe fn reset_handler() {
    sam4l::init();

    // Workaround for SB.02 hardware bug
    // TODO(alevy): Get rid of this when we think SB.02 are out of circulation
    sam4l::gpio::PA[14].enable();
    sam4l::gpio::PA[14].set();
    sam4l::gpio::PA[14].enable_output();


    // Source 32Khz and 1Khz clocks from RC23K (SAM4L Datasheet 11.6.8)
    sam4l::bpm::set_ck32source(sam4l::bpm::CK32Source::RC32K);



    set_pin_primary_functions();

    let console = static_init!(
        Console<usart::USART>,
        Console::new(&usart::USART3,
                     &mut console::WRITE_BUF,
                     main::Container::create()),
        24);
    usart::USART3.set_client(console);

    let ast = &sam4l::ast::AST;

    let mux_alarm = static_init!(
        MuxAlarm<'static, sam4l::ast::Ast>,
        MuxAlarm::new(&sam4l::ast::AST),
        16);
    ast.configure(mux_alarm);

    let mux_i2c2 = static_init!(drivers::virtual_i2c::MuxI2C<'static>, drivers::virtual_i2c::MuxI2C::new(&sam4l::i2c::I2C2), 20);
    sam4l::i2c::I2C2.set_client(mux_i2c2);

    let virtual_alarm1 = static_init!(
        VirtualMuxAlarm<'static, sam4l::ast::Ast>,
        VirtualMuxAlarm::new(mux_alarm),
        24);
    let timer = static_init!(
        TimerDriver<'static, VirtualMuxAlarm<'static, sam4l::ast::Ast>>,
        TimerDriver::new(virtual_alarm1, main::Container::create()),
        12);
    virtual_alarm1.set_client(timer);

    // Initialize and enable SPI HAL
    // let spi = static_init!(
    //     drivers::spi::Spi<'static, sam4l::spi::Spi>,
    //     drivers::spi::Spi::new(&mut sam4l::spi::SPI),
    //     84);
    // spi.config_buffers(&mut spi_read_buf, &mut spi_write_buf);
    // sam4l::spi::SPI.init(spi as &hil::spi_master::SpiCallback);


    ////////////////////////////////////////////////////////////////////////////
    // GPIO EXTENDERS
    ////////////////////////////////////////////////////////////////////////////

    // I2C Bus
    let mux_i2c1 = static_init!(drivers::virtual_i2c::MuxI2C<'static>, drivers::virtual_i2c::MuxI2C::new(&sam4l::i2c::I2C1), 20);
    sam4l::i2c::I2C1.set_client(mux_i2c1);

    // Configure the MCP23008_0. Device address 0x20
    let mcp23008_0_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x20), 32);
    let mcp23008_0 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_0_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_0_i2c.set_client(mcp23008_0);

    // Configure the MCP23008_1. Device address 0x21
    let mcp23008_1_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x21), 32);
    let mcp23008_1 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_1_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_1_i2c.set_client(mcp23008_1);

    // Configure the MCP23008_2. Device address 0x22
    let mcp23008_2_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x22), 32);
    let mcp23008_2 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_2_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_2_i2c.set_client(mcp23008_2);

    // Configure the MCP23008_5. Device address 0x25
    let mcp23008_5_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x25), 32);
    let mcp23008_5 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_5_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_5_i2c.set_client(mcp23008_5);

    // Configure the MCP23008_6. Device address 0x26
    let mcp23008_6_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x26), 32);
    let mcp23008_6 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_6_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_6_i2c.set_client(mcp23008_6);

    // Configure the MCP23008_7. Device address 0x27
    let mcp23008_7_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x27), 32);
    let mcp23008_7 = static_init!(
        signpost_drivers::mcp23008::MCP23008<'static>,
        signpost_drivers::mcp23008::MCP23008::new(mcp23008_7_i2c, &mut signpost_drivers::mcp23008::BUFFER),
        224/8);
    mcp23008_7_i2c.set_client(mcp23008_7);

    let async_gpio_ports = static_init!(
        [&'static signpost_drivers::mcp23008::MCP23008; 6],
        [mcp23008_0,
         mcp23008_1,
         mcp23008_2,
         mcp23008_5,
         mcp23008_6,
         mcp23008_7],
         192/8
    );

    let gpio_async = static_init!(
        signpost_drivers::gpio_async::GPIOAsync<'static, signpost_drivers::mcp23008::MCP23008<'static>>,
        signpost_drivers::gpio_async::GPIOAsync::new(async_gpio_ports),
        160/8
    );
    for port in async_gpio_ports.iter() {
        port.set_client(gpio_async);
    }



    // Configure the I2C selectors.
    let pca9544a_0_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x70), 32);
    let pca9544a_0 = static_init!(
        signpost_drivers::pca9544a::PCA9544A<'static>,
        // signpost_drivers::pca9544a::PCA9544A::new(pca9544a_0_i2c, Some(&sam4l::gpio::PA[9]), &mut signpost_drivers::pca9544a::BUFFER),
        signpost_drivers::pca9544a::PCA9544A::new(pca9544a_0_i2c, None, &mut signpost_drivers::pca9544a::BUFFER),
        288/8);
    pca9544a_0_i2c.set_client(pca9544a_0);
    // sam4l::gpio::PA[9].set_client(pca9544a_0);

    let pca9544a_1_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x71), 32);
    let pca9544a_1 = static_init!(
        signpost_drivers::pca9544a::PCA9544A<'static>,
        // signpost_drivers::pca9544a::PCA9544A::new(pca9544a_0_i2c, Some(&sam4l::gpio::PA[10]), &mut signpost_drivers::pca9544a::BUFFER),
        signpost_drivers::pca9544a::PCA9544A::new(pca9544a_0_i2c, None, &mut signpost_drivers::pca9544a::BUFFER),
        288/8);
    pca9544a_1_i2c.set_client(pca9544a_1);
    // sam4l::gpio::PA[10].set_client(pca9544a_1);


    let i2c_selectors = static_init!(
        [&'static signpost_drivers::pca9544a::PCA9544A; 2],
        [pca9544a_0,
         pca9544a_1],
         64/8
    );

    let i2c_selector = static_init!(
        signpost_drivers::i2c_selector::I2CSelector<'static, signpost_drivers::pca9544a::PCA9544A<'static>>,
        signpost_drivers::i2c_selector::I2CSelector::new(i2c_selectors),
        160/8
    );
    for selector in i2c_selectors.iter() {
        selector.set_client(i2c_selector);
    }

    // Setup the driver for the coulomb counter. We only use one because
    // they all share the same address, so one driver can be used for any
    // of them based on which port is selected on the i2c selector.
    let ltc2941_i2c = static_init!(drivers::virtual_i2c::I2CDevice, drivers::virtual_i2c::I2CDevice::new(mux_i2c1, 0x64), 32);
    let ltc2941 = static_init!(
        signpost_drivers::ltc2941::LTC2941<'static>,
        signpost_drivers::ltc2941::LTC2941::new(ltc2941_i2c, None, &mut signpost_drivers::ltc2941::BUFFER),
        288/8);
    ltc2941_i2c.set_client(ltc2941);

    let ltc2941driver = static_init!(
        signpost_drivers::ltc2941::LTC2941Driver<'static>,
        signpost_drivers::ltc2941::LTC2941Driver::new(ltc2941),
        128/8);
    ltc2941.set_client(ltc2941driver);


    // SPI

    let mux_spi = static_init!(signpost_drivers::virtual_spi_master::MuxSPIMaster<'static>, signpost_drivers::virtual_spi_master::MuxSPIMaster::new(&sam4l::spi::SPI), 128/8);
    sam4l::spi::SPI.init(mux_spi);



    // Setup FRAM driver
    let fm25cl_spi = static_init!(signpost_drivers::virtual_spi_master::SPIMasterDevice, signpost_drivers::virtual_spi_master::SPIMasterDevice::new(mux_spi, Some(2), None), 480/8);
    let fm25cl = static_init!(
        signpost_drivers::fm25cl::FM25CL<'static>,
        signpost_drivers::fm25cl::FM25CL::new(fm25cl_spi, &mut signpost_drivers::fm25cl::TXBUFFER, &mut signpost_drivers::fm25cl::RXBUFFER),
        352/8);
    fm25cl_spi.set_client(fm25cl);


    // set GPIO driver controlling remaining GPIO pins
    let gpio_pins = static_init!(
        [&'static sam4l::gpio::GPIOPin; 12],
        [&sam4l::gpio::PC[10], // LED_0
         &sam4l::gpio::PA[16], // P2
         &sam4l::gpio::PA[12], // P3
         &sam4l::gpio::PC[9], // P4
         &sam4l::gpio::PA[10], // P5
         &sam4l::gpio::PA[11], // P6
         &sam4l::gpio::PA[19], // P7
         &sam4l::gpio::PA[13], // P8
         &sam4l::gpio::PA[17], /* STORM_INT (nRF51822) */
         &sam4l::gpio::PC[14], /* RSLP (RF233 sleep line) */
         &sam4l::gpio::PC[15], /* RRST (RF233 reset line) */
         &sam4l::gpio::PA[20]], /* RIRQ (RF233 interrupt) */
        12 * 4
    );
    let gpio = static_init!(
        drivers::gpio::GPIO<'static, sam4l::gpio::GPIOPin>,
        drivers::gpio::GPIO::new(gpio_pins),
        20);
    for pin in gpio_pins.iter() {
        pin.set_client(gpio);
    }

    // Note: The following GPIO pins aren't assigned to anything:
    // &sam4l::gpio::PC[19] // !ENSEN
    // &sam4l::gpio::PC[13] // ACC_INT1
    // &sam4l::gpio::PC[20] // ACC_INT2
    // &sam4l::gpio::PA[14] // No Connection
    //

    let signpost_controller = static_init!(
        SignpostController,
        SignpostController {
            console: console,
            gpio: gpio,
            timer: timer,
            // spi: spi,
            gpio_async: gpio_async,
            coulomb_counter_i2c_selector: i2c_selector,
            coulomb_counter_generic: ltc2941driver,
        },
        192/8);

    usart::USART3.configure(usart::USARTParams {
        // client: &console,
        baud_rate: 115200,
        data_bits: 8,
        parity: hil::uart::Parity::None,
        mode: hil::uart::Mode::Normal,
    });

    // Setup USART2 for the nRF51822 connection
    usart::USART2.configure(usart::USARTParams {
        baud_rate: 250000,
        data_bits: 8,
        parity: hil::uart::Parity::Even,
        mode: hil::uart::Mode::FlowControl,
    });
    // // Configure USART2 Pins for connection to nRF51822
    // // NOTE: the SAM RTS pin is not working for some reason. Our hypothesis is
    // //  that it is because RX DMA is not set up. For now, just having it always
    // //  enabled works just fine
    // sam4l::gpio::PC[07].enable();
    // sam4l::gpio::PC[07].enable_output();
    // sam4l::gpio::PC[07].clear();


    // Uncommenting the following line will cause the device to use the
    // SPI HAL to write [8, 7, 6, 5, 4, 3, 2, 1] once over the SPI then
    // echo the 8 bytes read from the slave continuously.
    // spi_dummy::spi_dummy_test();

    // Uncommenting the following line will toggle the LED whenever the value of
    // Firestorm's pin 8 changes value (e.g., connect a push button to pin 8 and
    // press toggle it).
    // gpio_dummy::gpio_dummy_test();

    // Uncommenting the following line will test the I2C
    // i2c_dummy::i2c_scan_slaves();
    // i2c_dummy::i2c_tmp006_test();
    // i2c_dummy::i2c_accel_test();
    // i2c_dummy::i2c_li_test();

    // Uncommenting the following lines will test the Flash Controller
    // flash_dummy::meta_test();
    // flash_dummy::set_read_write_test();

    signpost_controller.console.initialize();
    // firestorm.nrf51822.initialize();

    let mut chip = sam4l::chip::Sam4l::new();
    chip.mpu().enable_mpu();





    struct TestFM<'a> {
        fm: &'a signpost_drivers::fm25cl::FM25CL<'static>,
        txtest: TakeCell<&'static mut [u8]>,
    };

    impl<'a> TestFM<'a> {
        pub fn new(fm: &'a signpost_drivers::fm25cl::FM25CL<'static>, txtest: &'static mut [u8]) -> TestFM<'a> {
            TestFM {
                fm: fm,
                txtest: TakeCell::new(txtest),
            }
        }
    }

    let txtest = static_init!(
        [u8; 10],
        [7, 0xb2, 0, 0, 0, 0, 0, 0, 0, 0],
        10*1
    );

    let rxtest = static_init!(
        [u8; 10],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        10*1
    );

    impl<'a> signpost_drivers::fm25cl::FM25CLClient for TestFM<'a> {
        fn status(&self, status: u8) {
            // panic!("status {}", status);
            self.txtest.take().map(|txtest| {
                // panic!("here");
                self.fm.write(8, txtest, 4);
            });

        }

        fn read(&self, data: &'static mut [u8]) {

        }

        fn done(&self, buffer: &'static mut [u8]) {
            // panic!("got done");
            self.fm.read(8, buffer, 4);

        }
    }

    let testfm = static_init!(
        TestFM,
        TestFM::new(fm25cl, txtest),
        96/8);

    fm25cl.set_client(testfm);

fm25cl.read_status();







    main::main(signpost_controller, &mut chip, load_processes());
}
