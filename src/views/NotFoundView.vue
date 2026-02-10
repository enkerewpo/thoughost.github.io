<template>
  <div class="not-found container">
    <div class="content">
      <h1>404</h1>
      <p>Page not found.</p>
      <a target="_top" href="/" class="back-link">Back to Home</a>
    </div>
  </div>
</template>

<style scoped>
.not-found {
  min-height: 50vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}
.content {
  text-align: center;
}
.not-found h1 {
  font-size: 3rem;
  font-weight: 600;
  margin-bottom: 0.5rem;
}
.not-found p {
  color: #666;
  margin-bottom: 1.5rem;
}
.back-link {
  font-weight: 600;
  text-decoration: underline;
}
.back-link:hover {
  color: #333;
}
</style>
