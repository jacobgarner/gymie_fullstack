-- CreateTable
CREATE TABLE "Exercises" (
    "exercise_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "muscle" TEXT NOT NULL,
    "equipment" TEXT NOT NULL,
    "difficulty" TEXT NOT NULL,
    "instructions" TEXT NOT NULL,

    CONSTRAINT "Exercises_pkey" PRIMARY KEY ("exercise_id")
);

-- CreateTable
CREATE TABLE "Users" (
    "user_id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "image_url" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "Workouts" (
    "workout_id" SERIAL NOT NULL,
    "workout_name" TEXT NOT NULL,
    "creator_id" INTEGER NOT NULL,

    CONSTRAINT "Workouts_pkey" PRIMARY KEY ("workout_id")
);

-- CreateTable
CREATE TABLE "ExercisesInWorkouts" (
    "exercise_id" INTEGER NOT NULL,
    "workout_id" INTEGER NOT NULL,

    CONSTRAINT "ExercisesInWorkouts_pkey" PRIMARY KEY ("exercise_id","workout_id")
);

-- CreateTable
CREATE TABLE "LoggedWorkouts" (
    "session_id" SERIAL NOT NULL,
    "exercise_id" INTEGER NOT NULL,
    "workout_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "reps" INTEGER NOT NULL,
    "completed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LoggedWorkouts_pkey" PRIMARY KEY ("session_id")
);

-- CreateTable
CREATE TABLE "Posts" (
    "post_id" SERIAL NOT NULL,
    "likes" INTEGER NOT NULL,
    "session_name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "session_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "Posts_pkey" PRIMARY KEY ("post_id")
);

-- CreateTable
CREATE TABLE "Comments" (
    "comment_id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "post_id" INTEGER NOT NULL,
    "body" TEXT NOT NULL,

    CONSTRAINT "Comments_pkey" PRIMARY KEY ("comment_id")
);

-- AddForeignKey
ALTER TABLE "Workouts" ADD CONSTRAINT "Workouts_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExercisesInWorkouts" ADD CONSTRAINT "ExercisesInWorkouts_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "Exercises"("exercise_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExercisesInWorkouts" ADD CONSTRAINT "ExercisesInWorkouts_workout_id_fkey" FOREIGN KEY ("workout_id") REFERENCES "Workouts"("workout_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoggedWorkouts" ADD CONSTRAINT "LoggedWorkouts_exercise_id_fkey" FOREIGN KEY ("exercise_id") REFERENCES "Exercises"("exercise_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoggedWorkouts" ADD CONSTRAINT "LoggedWorkouts_workout_id_fkey" FOREIGN KEY ("workout_id") REFERENCES "Workouts"("workout_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LoggedWorkouts" ADD CONSTRAINT "LoggedWorkouts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Posts" ADD CONSTRAINT "Posts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Posts" ADD CONSTRAINT "Posts_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "LoggedWorkouts"("session_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "Posts"("post_id") ON DELETE RESTRICT ON UPDATE CASCADE;
