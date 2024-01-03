const { PrismaClient } = require("@prisma/client");
const exercises = require("./prisma/data/exercises");
const users = require("./prisma/data/users");
const workouts = require("./prisma/data/workouts");
const addExercises = require("./prisma/data/addExercises");
const loggedWorkouts = require("./prisma/data/loggedWorkouts");
const posts = require("./prisma/data/posts");
const comments = require("./prisma/data/comments");

const prisma = new PrismaClient();

async function main() {
  // Clears existing data from database
  await prisma.$executeRaw`TRUNCATE TABLE "Comments" RESTART IDENTITY CASCADE`;
  await prisma.$executeRaw`TRUNCATE TABLE "Posts" RESTART IDENTITY CASCADE`;
  await prisma.$executeRaw`TRUNCATE TABLE "LoggedWorkouts" RESTART IDENTITY CASCADE`;
  await prisma.$executeRaw`TRUNCATE TABLE "ExercisesInWorkouts"`;
  await prisma.$executeRaw`TRUNCATE TABLE "Exercises" RESTART IDENTITY CASCADE`;
  await prisma.$executeRaw`TRUNCATE TABLE "Workouts" RESTART IDENTITY CASCADE`;
  await prisma.$executeRaw`TRUNCATE TABLE "Users" RESTART IDENTITY CASCADE`;

  // Insert the provided data into the database
  await prisma.exercises.createMany({
    data: exercises,
  });
  await prisma.users.createMany({ data: users });
  await prisma.workouts.createMany({ data: workouts });
  await prisma.ExercisesInWorkouts.createMany({ data: addExercises });
  await prisma.LoggedWorkouts.createMany({ data: loggedWorkouts });
  await prisma.Posts.createMany({ data: posts });
  await prisma.Comments.createMany({ data: comments });
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })

  .catch(async (e) => {
    console.error(e);

    await prisma.$disconnect();

    process.exit(1);
  });
