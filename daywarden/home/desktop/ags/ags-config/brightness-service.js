class BrightnessService extends Service {
    static {
        Service.register(
            this,
            {
                'screen-changed': ['float'],
            },
            {
                'screen-value': ['float', 'rw'],
            },
        );
    }
    #front = "intel_backlight";
    #back = "asus_screenpad";
    #screenValue = 0;
    #max = Number(Utils.exec(`brightnessctl max --device=${this.#front}`));
    get screen_value() {
        return this.#screenValue;
    }
    set screen_value(percent) {
        if (percent < 0)
            percent = 0;
        if (percent > 1)
            percent = 1;
        Utils.execAsync(`brightnessctl set --device=${this.#front} ${percent * 100}% -q`);
        Utils.execAsync(`brightnessctl set --device=${this.#back} ${percent * 100}% -q`);
    }

    constructor() {
        super();
        const brightness = `/sys/class/backlight/${this.#front}/brightness`;
        Utils.monitorFile(brightness, () => this.#onChange());
        this.#onChange();
    }

    #onChange() {
        this.#screenValue = Number(Utils.exec(`brightnessctl get --device=${this.#front}`)) / this.#max;
        this.changed('screen-value');
        this.emit('screen-changed', this.#screenValue);
    }
    connect(event = 'screen-changed', callback) {
        return super.connect(event, callback);
    }
}

const service = new BrightnessService;
export default service;