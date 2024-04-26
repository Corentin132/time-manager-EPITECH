<script setup lang="ts"></script>

<template>
    <h1>ClockManager Component</h1>
    <p>
        - used to declare hours worked ; 2 - connected to the /clock/:username route ; - it must have: * startDateTime data (is worth null if no work period is in progress) ; * clockIn (a boolean that
        is true if a work period is in progress) ; * refresh() and clock() methods (to pass from active to inactive and vice versa).
    </p>
</template>

