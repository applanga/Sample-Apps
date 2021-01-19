package com.example.weatherapp.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.example.weatherapp.MainActivity
import com.example.weatherapp.databinding.FragmentHomeBinding
import com.example.weatherapp.networking.modules.current.ApiResponseCurrent
import com.example.weatherapp.utils.DateTimeHelper
import com.example.weatherapp.utils.IconHelper

class HomeFragment : Fragment() {

    lateinit var binding: FragmentHomeBinding

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        binding = FragmentHomeBinding.inflate(inflater)
        setHomeObserver()
        return binding.root
    }

    private fun setHomeObserver() {
        if (requireActivity() is MainActivity) {
            (requireActivity() as MainActivity).currentWeather.observe(viewLifecycleOwner) {
                initUiHome(it)
                hideSpinner()
            }
        }
    }

    private fun hideSpinner() {
        binding.apply {
            homeProgressBarBackground?.visibility = View.GONE
            homeProgressBarSpinner?.visibility = View.GONE
        }
    }

    private fun initUiHome(apiResponse: ApiResponseCurrent?) {
        if (apiResponse != null) {
            binding.apply {
                homeWeather = apiResponse
                homeDate.text = DateTimeHelper().getCurrentDate()
                homeWeatherIcon.setImageResource(IconHelper.getWeatherIcon(apiResponse.weather[0].icon))
            }
        }
    }

}