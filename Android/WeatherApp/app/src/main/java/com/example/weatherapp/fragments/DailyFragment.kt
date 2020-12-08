package com.example.weatherapp.fragments

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.weatherapp.R
import com.example.weatherapp.adapters.DailyAdapter
import com.example.weatherapp.constants.Settings
import com.example.weatherapp.databinding.FragmentDailyBinding
import com.example.weatherapp.networking.Repository
import com.example.weatherapp.networking.interfaces.NetworkRequestListenerDaily
import com.example.weatherapp.networking.modules.daily.ApiResponseDaily
import com.example.weatherapp.networking.modules.daily.Day

class DailyFragment : Fragment(), NetworkRequestListenerDaily {

    val repository = Repository()
    private lateinit var binding: FragmentDailyBinding
    private lateinit var recyclerView: RecyclerView
    private val dailyAdapterFixedData = mutableListOf<Day>()
    private val dailyAdapterMutableData = mutableListOf<Day>()
    private val dailyAdapter = DailyAdapter(requireActivity(), dailyAdapterMutableData)
    private val spinnerOptions = arrayOf("1", "2", "3", "4", "5")

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?): View? {
            binding = FragmentDailyBinding.inflate(inflater)
            recyclerView = binding.recyclerViewDaily
            recyclerView.adapter = dailyAdapter

            initUiDaily()
            return binding.root
    }

    override fun onResume() {
        super.onResume()

        val sharedPreferences = requireActivity().getSharedPreferences(Settings.SHARED_PREFERENCES.toString(), Context.MODE_PRIVATE)
        val city = sharedPreferences.getString(Settings.CITY_KEY.toString(), null)
        val units = sharedPreferences.getString(Settings.UNITS_KEY.toString(), null)
        if (city != null && units != null) {
            repository.fetchDailyWeather(this, city, units)
        }
    }

    override fun onCompleteNetworkRequest(apiResponseDaily: ApiResponseDaily?) {
        dailyAdapterFixedData.addAll(apiResponseDaily?.list ?: listOf())
        dailyAdapterMutableData.addAll(dailyAdapterFixedData)
        dailyAdapter.notifyDataSetChanged()
    }

    override fun onNetworkRequestError(error: Throwable) {
        Toast.makeText(context, error.message, Toast.LENGTH_LONG).show()
    }

    fun initUiDaily() {
        binding.apply {
            recyclerViewDaily.layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            recyclerViewDaily.adapter = dailyAdapter
            spinnerDaily.apply {
                adapter = ArrayAdapter(
                        requireActivity(),
                        R.layout.spinner_days_item,
                        spinnerOptions
                )
                (adapter as ArrayAdapter<*>).setDropDownViewResource(R.layout.spinner_dropdown_item)
                setSelection(4)
                onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                    override fun onItemSelected(p0: AdapterView<*>?, p1: View?, p2: Int, p3: Long) {
                        setSelection(p2)

                        val itemsNumber = (p2+1)*4

                        if (itemsNumber <= dailyAdapterFixedData.size) {
                            dailyAdapterMutableData.clear()
                            dailyAdapterMutableData.addAll(dailyAdapterFixedData.subList(0, itemsNumber))
                            dailyAdapter.notifyDataSetChanged()
                        }
                    }

                    override fun onNothingSelected(p0: AdapterView<*>?) {
                    }
                }

            }
        }
    }

//    fun initRecyclerView(apiResponseDaily: ApiResponseDaily?) {
//        if (apiResponseDaily != null) {
//            recyclerView.adapter = DailyAdapter(activityContext, apiResponseDaily.list)
//            (recyclerView.adapter as DailyAdapter).notifyDataSetChanged()
//        }
//    }


}