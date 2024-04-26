export interface Login {
    user: {
        email: string
        password: string
    }
}

export interface User {
    id: string
    username: string
    email: string
    first_name: string
    last_name: string
    password: string
    avatar?: string
    role?: string
}

export interface Register {
    user: {
        first_name: string
        last_name: string
        username: string
        email: string
        password: string
        role: string
    }
}

export interface Response {
    message: string
    user_return_to: string
    id: number
}
