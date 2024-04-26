<script setup lang="ts">
import { get_all_user, delete_user, changer_user_role } from "../../api/user"
// import { User } from "../../types/users"
import { ref } from "vue"
import { User } from "../../types/users"
let all_users = ref([{ id: "", username: "", email: "", password: "", first_name: "loading", last_name: "", role: "" }])
let update_role = "manager"
const fetchData = async () => {
    all_users.value = await get_all_user()
    console.log(all_users)
}
fetchData()
const handleChangeRole = async (user: User, role: string) => {
    const old_role = user.role
    try {
        user.role = role

        await changer_user_role(user, user.id)

        alert(`${user.first_name} ${user.last_name} role has changed to ${user.role}`)
    } catch {
        user.role = old_role
        alert("Can't change role of the user ")
    }
}
const handleDeleteUser = async (user: User) => {
    try {
        const res = await delete_user(user.id)
        if (res.data.status === 200) {
            alert(`The user ${user.first_name} ${user.last_name} has been deleted`)
        }
    } catch {
        alert("Cant delete the user")
    }
}
</script>

<template>
    <div>
        <h4>All users</h4>
        <ul class="wrapper-admin-info" v-for="user in all_users" :key="user.id" id="container-users">
            <div class="container-btn-user">
                <div class="wrapper-user-info">
                    <li><strong>Username :</strong> {{ user.username }}</li>
                    <li><strong>Email :</strong>{{ user.email }}</li>
                    <li><strong>First name :</strong> {{ user.first_name }}</li>
                    <li><strong>Last name :</strong> {{ user.last_name }}</li>
                    <li><strong>Role :</strong> {{ user.role }}</li>
                </div>

                <div class="wrapper-option-admin">
                    <div>
                        <button @click="handleChangeRole(user, update_role)" class="btn-option-admin">Change role</button>

                        <select v-model="update_role">
                            <option value="user">User</option>
                            <option selected value="manager">Manager</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>

                    <button @click="handleDeleteUser(user)" class="btn-option-admin delete">Delete user</button>
                </div>
            </div>
        </ul>
    </div>
</template>
<style lang="scss">
.wrapper-admin-info {
    .container-btn-user {
        border-bottom: solid 1px black;
        display: flex;
        align-items: center;
        justify-content: space-between;
        list-style: none;
        .wrapper-user-info {
            display: flex;
            justify-content: center;
            align-items: start;
            flex-direction: column;
        }

        .wrapper-option-admin {
            display: flex;
            font-weight: 600;

            flex-direction: column;
            .btn-option-admin {
                margin: 10px;
                background-color: #c0d3f5;
                color: #0154d6;
            }
            .delete {
                background-color: #ffc5c4;
                color: #fb180e;
            }
        }
    }
}
</style>
