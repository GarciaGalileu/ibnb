package com.example.ibnb

import android.app.Activity
import android.os.Bundle
import com.mercadopago.android.px.core.MercadoPagoCheckout
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import com.mercadopago.android.px.model.Payment

class MainActivity: FlutterActivity() {
    private val REQUEST_CODE = 1;
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initFlutterChannels()
    }

    private fun initFlutterChannels() {
        val canalMercadoPago = MethodChannel(flutterView, "ibnb.com/mercadoPago")
        canalMercadoPago.setMethodCallHandler { call, result ->
            val args = call.arguments as HashMap<String, Any>;
            val publicKey = args["publicKey"] as String
            val preferenceId = args["preferenceId"] as String

            when(call.method) {
                "mercadoPago" -> mercadoPago(publicKey, preferenceId, result)
                else -> return@setMethodCallHandler
            }
        }
    }

    private fun mercadoPago(publicKey: String, preferenceId: String, channelResult: MethodChannel.Result) {
        MercadoPagoCheckout.Builder(publicKey, preferenceId)
                .build()
                .startPayment(this@MainActivity, REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val canalMercadoPagoResposta = MethodChannel(flutterView, "ibnb.com/mercadoPagoResposta")
        if(resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE) {
            val payment = data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
            val paymentStatus = payment.paymentStatus
            val paymentStatusDetails = payment.paymentStatusDetail
            val paymentID = payment.id

            val arrayList = ArrayList<String>()
            arrayList.add(paymentID.toString())
            arrayList.add(paymentStatus)
            arrayList.add(paymentStatusDetails)

            canalMercadoPagoResposta.invokeMethod("mercadoPagoOK", arrayList)
        } else if (resultCode == Activity.RESULT_CANCELED) {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoError")
            canalMercadoPagoResposta.invokeMethod("mercadoPagoError", arrayList)
        } else {
            val arrayList = ArrayList<String>()
            arrayList.add("pagoCancelado")
            canalMercadoPagoResposta.invokeMethod("mercadoPagoError", arrayList)
        }

    }
}
