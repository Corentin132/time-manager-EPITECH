<script setup lang="ts">
import Profile from "../components/Profile.vue"
import UserTopBar from "../components/user_profile/UserTopBar.vue"
</script>

<template>
    <main>
        <UserTopBar :message="'Profile'" />
        <Profile />
    </main>
</template>
