<script setup lang="ts">
import Users from "../components/admin_users/users.vue"
import UserTopBar from "../components/user_profile/UserTopBar.vue"
</script>

<template>
    <UserTopBar :message="'Admin Panel'" />
    <Users></Users>
</template>

<style lang="scss">
.user-container {
    display: flex;
    flex-direction: column;
    align-items: center;

    .container-my-stat {
        display: flex;
        flex-direction: column;
        width: 390px;
        height: 280px;
        margin: 20px 0;

        border-radius: 20px;
        border: 0.5px solid black;

        .my-stat {
            font-size: 20px;
            font-family: "Poppins", sans-serif;
            font-weight: 500;
            text-align: left;
            margin-left: 2vw;
            line-height: normal;
        }

        .wrapper-my-stat {
            display: flex;
            flex-direction: row;
        }
    }
}
</style>
