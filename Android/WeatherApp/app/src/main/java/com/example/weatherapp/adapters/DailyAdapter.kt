package com.example.weatherapp.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.weatherapp.databinding.DayRowBinding
import com.example.weatherapp.networking.modules.daily.Day
import com.example.weatherapp.utils.DateHelper
import com.squareup.picasso.Picasso


class DailyAdapter(val context: Context ,val days: List<Day>): RecyclerView.Adapter<DayViewHolder>() {

    override fun getItemCount(): Int {
        return days.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DayViewHolder {
        val layoutInfalter = LayoutInflater.from(parent.context)
        val databinding = DayRowBinding.inflate(layoutInfalter, parent, false)
        return DayViewHolder(context ,databinding)
    }

    override fun onBindViewHolder(viewHolder: DayViewHolder, position: Int) {
        viewHolder.bind(days[position])
    }

}

class DayViewHolder(val context: Context, val dayRowBinding: DayRowBinding): RecyclerView.ViewHolder(dayRowBinding.root) {

    private fun getTime(): String {
        val initialTime = dayRowBinding!!.dayRow!!.dt_txt!!.substring(11, 16)
        val suffix = if (dayRowBinding!!.dayRow!!.dt_txt!!.substring(11, 13).toInt() > 11) "PM" else "AM"
        return "$initialTime $suffix"
    }

    fun bind(day: Day) {
        dayRowBinding.dayRow = day
        dayRowBinding.dailyDateData.text = DateHelper.getCurrentDateTTN()
        dayRowBinding.dailyTimeData.text = getTime()
        val iconUrl = "http://openweathermap.org/img/wn/${day.weather[0].icon}@2x.png"
        Picasso.get().load(iconUrl).into(dayRowBinding.dailyIcon)
    }
}
