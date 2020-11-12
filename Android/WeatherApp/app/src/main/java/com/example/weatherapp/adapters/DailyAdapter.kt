package com.example.weatherapp.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.weatherapp.databinding.DayRowBinding
import com.example.weatherapp.networking.modules.daily.ApiResponseDaily
import com.example.weatherapp.networking.modules.daily.Day
import com.squareup.picasso.Picasso


class DailyAdapter(val context: Context ,val days: ApiResponseDaily): RecyclerView.Adapter<DayViewHolder>() {

    override fun getItemCount(): Int {
        return days.list.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DayViewHolder {
        val layoutInfalter = LayoutInflater.from(parent.context)
        val databinding = DayRowBinding.inflate(layoutInfalter, parent, false)
        return DayViewHolder(context ,databinding)
    }

    override fun onBindViewHolder(viewHolder: DayViewHolder, position: Int) {
        viewHolder.bind(days.list[position])
    }

}

class DayViewHolder(val context: Context, val dayRowBinding: DayRowBinding): RecyclerView.ViewHolder(dayRowBinding.root) {
    fun bind(day: Day) {
        dayRowBinding.dayRow = day
        val iconUrl = "http://openweathermap.org/img/wn/${day.weather[0].icon}@2x.png"
        Picasso.get().load(iconUrl).into(dayRowBinding.dailyIcon)
    }
}
