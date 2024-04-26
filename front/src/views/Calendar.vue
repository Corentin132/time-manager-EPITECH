<script setup lang="ts">
import WorkingTimes from "../components/WorkingTimes.vue"
import UserTopBar from "../components/user_profile/UserTopBar.vue"
</script>
<template>
    <div>
        <UserTopBar :message="'Here your workingtimes '" />
        <WorkingTimes></WorkingTimes>
    </div>
</template>
