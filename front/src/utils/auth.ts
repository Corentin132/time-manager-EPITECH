const email_regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

const pwd_regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/

export const requiredPwd = (password: string) => {
    if (password.match(pwd_regex)) {
        return true
    } else {
        return "Please enter a valid  password, with minimum one Upper case , Lower caser, Number and a special character (@, #, $, %, ^, &, +, =, !)"
    }
}
export const requiredEmail = (email: string) => {
    if (email.toLowerCase().match(email_regex)) {
        return true
    } else {
        return " Please enter a valid email"
    }
}
