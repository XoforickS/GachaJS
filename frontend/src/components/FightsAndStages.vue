<template>
  <div>
    <div v-for="stage in stages" :key="stage.id">
      <router-link :to="'/prepare/' + stage.id">{{ stage.name }}</router-link>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      stages: [], // Fetch stages from the API
    };
  },
  mounted() {
    this.loadStages();
  },
  methods: {
    async loadStages() {
      try {
        const response = await fetch('http://localhost:8000/stages/');
        const stageData = await response.json();

        this.stages = stageData;
      } catch (error) {
        console.error('Error loading stage data:', error);
      }
    },
  },
};
</script>
