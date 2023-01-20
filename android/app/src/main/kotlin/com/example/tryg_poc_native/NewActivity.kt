package com.example.tryg_poc_native

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.example.tryg_poc_native.R

class NewActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_new)

        val textView = findViewById<TextView>(R.id.textView)
        textView.text = "This is the new activity"
    }
}