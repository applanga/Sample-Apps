package com.example.weatherapp.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.weatherapp.R
import com.example.weatherapp.databinding.ItemDayBinding
import com.example.weatherapp.networking.modules.daily.Day
import com.example.weatherapp.utils.DateTimeHelper
import com.example.weatherapp.utils.IconHelper

class DailyAdapter(val context: Context?, private val days: List<Day>) : RecyclerView.Adapter<DayViewHolder>() {

    override fun getItemCount(): Int {
        return days.size
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DayViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val binding = ItemDayBinding.inflate(layoutInflater, parent, false)
        return DayViewHolder(context, binding)
    }

    override fun onBindViewHolder(viewHolder: DayViewHolder, position: Int) {
        viewHolder.bind(days[position])
    }

}

class DayViewHolder(val context: Context?, val binding: ItemDayBinding): RecyclerView.ViewHolder(binding.root) {

    private val dateTimeHelper = DateTimeHelper()

    private fun getTime() : String {
        val time = binding.dayItem!!.dt_txt.substring(11, 16)
        val suffix = if (binding.dayItem!!.dt_txt.substring(11, 13).toInt() > 11) {
            context?.getString(R.string.daily_pm).toString()
        } else context?.getString(R.string.daily_am).toString()
        return "$time $suffix"
    }

    fun bind(day: Day) {

        binding.apply {
            dayItem = day
            dayDate.text = dateTimeHelper.getFullDate(day.dt_txt.substring(0, 10))
            dayTime.text = getTime()
            dayIcon.setImageResource(IconHelper.getWeatherIcon(day.weather[0].icon))
        }
    }
}