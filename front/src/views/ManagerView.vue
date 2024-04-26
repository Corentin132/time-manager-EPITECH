<script setup lang="ts">
import Manager from "../components/Manager.vue"
import UserTopBar from "../components/user_profile/UserTopBar.vue"
</script>
<template>
    <div>
        <UserTopBar :message="'Manager view'" />
        <Manager></Manager>
    </div>
</template>
