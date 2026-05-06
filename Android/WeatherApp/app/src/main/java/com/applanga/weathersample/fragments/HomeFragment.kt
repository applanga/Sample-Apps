package com.applanga.weathersample.fragments

import android.os.Bundle
import android.os.SystemClock
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.applanga.android.Applanga
import com.applanga.weathersample.MainActivity
import com.applanga.weathersample.databinding.FragmentHomeBinding
import com.applanga.weathersample.networking.modules.current.ApiResponseCurrent
import com.applanga.weathersample.utils.DateTimeHelper
import com.applanga.weathersample.utils.IconHelper

class HomeFragment : Fragment() {

    lateinit var binding: FragmentHomeBinding

    private var iconClickCount = 0
    private var lastIconClickTime = 0L
    private var dateClickCount = 0
    private var lastDateClickTime = 0L
    private var showOverlay = false

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View {
        binding = FragmentHomeBinding.inflate(inflater)
        setHomeObserver()
        binding.homeWeatherIcon.setOnClickListener { onIconClicked() }
        binding.homeDate.setOnClickListener { onDateClicked() }
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

    private fun onIconClicked() {
        val now = SystemClock.elapsedRealtime()
        iconClickCount = if (now - lastIconClickTime <= 800L) iconClickCount + 1 else 1
        lastIconClickTime = now
        if (iconClickCount >= 8) {
            Applanga.showDraftModeDialog(activity)
            iconClickCount = 0
        }
    }

    private fun onDateClicked() {
        val now = SystemClock.elapsedRealtime()
        dateClickCount = if (now - lastDateClickTime <= 800L) dateClickCount + 1 else 1
        lastDateClickTime = now
        if (dateClickCount >= 8) {
            showOverlay = !showOverlay
            Applanga.setScreenShotMenuVisible(showOverlay)
            dateClickCount = 0
        }
    }

    private fun hideSpinner() {
        binding.apply {
            homeProgressBarBackground.visibility = View.GONE
            homeProgressBarSpinner.visibility = View.GONE
        }
    }

    private fun initUiHome(apiResponse: ApiResponseCurrent?) {
        if (apiResponse != null) {
            binding.apply {
                homeWeather = apiResponse
                homeDate.text = DateTimeHelper(requireContext()).getCurrentDate()
                homeWeatherIcon.setImageResource(IconHelper.getWeatherIcon(apiResponse.weather[0].icon))
            }
        }
    }

}