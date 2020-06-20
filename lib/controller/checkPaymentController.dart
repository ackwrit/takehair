import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class checkPaymentController extends StatefulWidget{
  int total;
  checkPaymentController(total)
  {
    this.total=total;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _homeCheckPayment();
  }



}

class _homeCheckPayment extends State <checkPaymentController>
{
  ///Déclaration variable
  ///
  ///
  ///
  ///
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  final String _currentSecret = "sk_test_EIn7PcMgJCh005IxqH1Kmmn600n4wtSOKC"; //set this yourself, e.g using curl
  PaymentIntentResult _paymentIntent;
  Source _source;

  ScrollController _controller = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  initState() {
    super.initState();

    StripePayment.setOptions(
        StripeOptions(publishableKey: "pk_test_QQ6EqdeL67aoCecNqLETZVke00kNCuIBte", merchantId: "COUCOU", androidPayMode: 'androidpaymethod',));
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Takehair'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: _body(),
    );
  }


  Widget _body()
  {
    return new Center(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: new Card(
            elevation: 20.0,
            child: new Column(
              children: <Widget>[
                RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text("Ajouter votre carte de paiement"),
                  onPressed: () {
                    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
                      setState(() {
                        _paymentMethod = paymentMethod;
                        print(_paymentMethod);

                      });
                    }).catchError(setError);
                  },
                ),

              ],
            ),
          ),
        )

    ) ;
  }

}