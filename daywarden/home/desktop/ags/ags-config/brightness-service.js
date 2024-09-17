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
    #screenValue = 0;
    #max = Number(Utils.exec(`brightnessctl max`));
    get screen_value() {
        return this.#screenValue;
    }
    set screen_value(percent) {
        if (percent < 0)
            percent = 0;
        if (percent > 1)
            percent = 1;
        Utils.execAsync(`brightnessctl set ${percent * 100}% -q`);
    }

    constructor() {
        super();
        const brightness = `/sys/class/backlight/intel_backlight/brightness`;
        Utils.monitorFile(brightness, () => this.#onChange());
        this.#onChange();
    }

    #onChange() {
        this.#screenValue = Number(Utils.exec(`brightnessctl get`)) / this.#max;
        this.changed('screen-value');
        this.emit('screen-changed', this.#screenValue);
    }
    connect(event = 'screen-changed', callback) {
        return super.connect(event, callback);
    }
}

const service = new BrightnessService;
export default service;