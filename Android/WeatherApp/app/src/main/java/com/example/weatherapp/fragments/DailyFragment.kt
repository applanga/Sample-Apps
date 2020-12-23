package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.weatherapp.MainActivity
import com.example.weatherapp.R
import com.example.weatherapp.adapters.DailyAdapter
import com.example.weatherapp.classes.SharedPrefrencesManager.Keys
import com.example.weatherapp.classes.WeatherAppApplication
import com.example.weatherapp.databinding.FragmentDailyBinding
import com.example.weatherapp.networking.modules.daily.Day

class DailyFragment : Fragment() {

    private lateinit var binding: FragmentDailyBinding
    private val displayedDays = WeatherAppApplication.app.sharedPrefrencesManager.getInt(
        Keys.DAYS_NUMBER_KEY.toString(),
        5
    )
    private val dailyAdapterMutableData = mutableListOf<Day>()
    private lateinit var dailyAdapter: DailyAdapter

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = FragmentDailyBinding.inflate(inflater)
        setDailyObserver()
        initUiDaily()
        return binding.root
    }

    private fun setDailyObserver() {
        if (requireActivity() is MainActivity) {
            (requireActivity() as MainActivity).dailyWeather.observe(viewLifecycleOwner) {
                dailyAdapterMutableData.addAll(it.list.subList(0, displayedDays * 8))
                dailyAdapter.notifyDataSetChanged()
            }
        }
    }

    private fun initUiDaily() {
        dailyAdapter = DailyAdapter(context, dailyAdapterMutableData)

        binding.apply {
            val screenOrientation = (requireContext().getSystemService(Context.WINDOW_SERVICE) as WindowManager).defaultDisplay.orientation

            if (screenOrientation == Surface.ROTATION_90) {
                // In landscape
                dailyRecyclerView.layoutManager = LinearLayoutManager(requireContext(), LinearLayoutManager.HORIZONTAL, false)
            } else {
                // In portrait
                dailyRecyclerView.layoutManager = LinearLayoutManager(requireContext())
            }
            dailyRecyclerView.adapter = dailyAdapter

            dailyDaysDisplay.text = resources.getQuantityString(
                R.plurals.daily_day_number,
                displayedDays,
                displayedDays
            )
        }
    }
}