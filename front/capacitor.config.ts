import { CapacitorConfig } from "@capacitor/cli"

const config: CapacitorConfig = {
    appId: "com.example.TimeManager",
    appName: "Time Manager",
    webDir: "dist",
    server: {
        androidScheme: "https",
    },
}

export default config
