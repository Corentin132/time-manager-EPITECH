//  -------------------------- HOW TO USE IT ----------------------
//  GET Example :
// const user = await api.get<User>('/api/users/42');
// POST Example : revoir si ça marche vraiment 😇
// const user = await api.post<User>('/api/users/42', user)

function request<TResponse>(url: string, config: RequestInit = {}): Promise<TResponse> {
    return fetch(url, config)
        .then((response) => response.json())
        .then((data) => data)
        .catch((error) => {
            // Handle the error.
            console.log("ERROR API CALL : ", error.message)
        })
}
export const api = {
    get: <TResponse>(url: string) => request<TResponse>(url),

    post: <TBody extends BodyInit, TResponse>(url: string, body: TBody) =>
        request<TResponse>(url, {
            method: "POST",
            body,
        }),

    delete: <TResponse>(url: string) => request<TResponse>(url, { method: "DELETE" }),

    put: <TBody extends BodyInit, TResponse>(url: string, body: TBody) => request<TResponse>(url, { method: "PUT", body }),
}
