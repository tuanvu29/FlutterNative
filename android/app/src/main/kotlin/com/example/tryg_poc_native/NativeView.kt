package com.example.tryg_poc_native

import NewActivity
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.view.View
import android.widget.Button
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView


private const val TAG = "NativeView"
internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val spinner: ProgressBar

    private val linearLayout: LinearLayout
    private val textView: TextView
    private val button: Button
    private var counter: Int = 0
    private val button2 = Button(context)

    override fun getView(): View {
        return linearLayout
    }

    override fun dispose() {}

    init {

        spinner = ProgressBar(context)
        spinner.visibility = View.VISIBLE

        linearLayout = LinearLayout(context)
        linearLayout.orientation = LinearLayout.VERTICAL

        textView = TextView(context)
        textView.textSize = 36f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "Button clicked $counter times (id: $id)"

        button = Button(context)
        button.text = creationParams?.get("a").toString()
        button.textSize = 12f
        button.setOnClickListener{
            this.counter += 1
            textView.text = "Button clicked $counter times (id: $id)"
        }

        button2.text = "Switch"
        button2.setOnClickListener {
            val intent = Intent(context, NewActivity::class.java)
            context.startActivity(intent)
        }


        linearLayout.addView(textView)
        linearLayout.addView(spinner)
        linearLayout.addView(button)
        linearLayout.addView(button2)
    }

}
