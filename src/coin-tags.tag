<cointrack>
    <button class="ui button green" onclick="{ add_fake_coin }">Add Fake Coin</button>

    <table class="ui table striped">
        <thead>
            <th>Coin</th>
            <th>Price</th>
        </thead>
        <tbody>
            <tr each="{ coin in coins }">
                <td>{ coin.name }</td>
                <td>{ coin.price }</td>
            </tr>
        </tbody>
    </table>

    <script>
        var self = this

        self.coins = {}

        self.get_btc_price = function() {
            $.get("https://api.coindesk.com/v1/bpi/currentprice.json")
                .done(function(data){
                    data = $.parseJSON(data)
                    console.log(data)
                    console.log(typeof(data))

                    self.coins['btc'] = {
                        name: data.chartName,
                        price: data["bpi"]["USD"]["rate"]
                    }

                    self.update()
                })
        }

//        self.get_ethereum_price = function() {
//            $.get("https://api.coindesk.com/v1/bpi/currentprice.json")
//                .done(function(data){
//                    console.log(data)
//                    var coins = [
//                        {
//                            name: data.chartName,
//                            price: data.bpi.USD.rate
//                        }
//                    ]
//                    self.update({coins: coins})
//                })
//        }

        self.on("mount", function() {

            var btc_price_loop = function() {
                self.get_btc_price()
                setTimeout(btc_price_loop, 5000)
            }
            btc_price_loop()
//            self.get_ethereum_price()
        })

        self.add_fake_coin = function() {
            self.coins["FRIENDS"] = {
                name: "FRNDZ",
                price: "69.9000"
            }
            self.update()
        }
    </script>
</cointrack>
