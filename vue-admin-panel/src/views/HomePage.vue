<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12" class="mt-16 mb-5">
        <v-img
          :src="logo.length > 0 ? logo : require('../assets/logo.svg')"
          contain
          height="100"
        />
      </v-col>
      <v-col cols="12">
        <h1
          class="text-h6 font-weight-bold mb-3"
          v-html="
            `${$t(
              'message.11'
            )}, <span class='orange--text font-size-1-4-rem'>${username}</span>.`
          "
        ></h1>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "HomePage",

  computed: {
    ...mapState(["logo", "username"]),
  },
};
</script>
