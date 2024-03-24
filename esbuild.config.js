#!/usr/bin/env node

const esbuild = require("esbuild");
const path = require("path");
const chokidar = require("chokidar");

// Add more entrypoints, if needed
const entryPoints = ["application.js"];

const watchDirectories = [
  "./app/javascript/**/*.js",
  "./app/views/**/*.html.erb",
  "./app/assets/stylesheets/*.css",
  "./app/assets/stylesheets/*.scss",
];

const config = {
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  bundle: true,
  entryPoints: entryPoints,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  sourcemap: true,
};

async function rebuild() {
  try {
    await esbuild.build({
      ...config,
      minify: process.env.RAILS_ENV === "production",
    });
    console.log("Build successful!");
  } catch (error) {
    console.error("Build failed:", error);
  }
}

chokidar.watch(watchDirectories).on("all", (event, path) => {
  if (path.includes("javascript")) {
    rebuild();
  }
});

// Initial build
rebuild();
