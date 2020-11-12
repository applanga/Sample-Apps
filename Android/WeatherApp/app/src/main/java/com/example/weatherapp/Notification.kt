package com.example.weatherapp

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

class Notification(
        val activityContext: Context,
        val allowNotification: Boolean,
        val channelId: String,
        val notificationId: Int,
        val title: String,
        val description: String
) {

    //    NOTIFICATION
    fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = "Title"
            val descriptionText = "Description"
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(channelId, name, importance).apply {
                description = descriptionText
            }
            val notificationManager: NotificationManager = activityContext.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    fun sendNotification() {
        if (!allowNotification) return

        val intent = Intent(activityContext, MainActivity::class.java)
        intent.putExtra(MainActivity.ACTION_KEY, MainActivity.START_FRAGMENT)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val pendingIntent = PendingIntent.getActivity(activityContext, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)

        val builder = NotificationCompat.Builder(activityContext, channelId)
                .setSmallIcon(R.mipmap.ic_stat_umbrella)
                .setContentTitle(title)
                .setContentText(description)
                .setContentIntent(pendingIntent)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)

        with(NotificationManagerCompat.from(activityContext)) {
            notify(notificationId, builder.build())
        }
    }
}