truffle compile
truffle migrate --reset

var account_one = "0x627306090abaB3A6e1400e9345bC60c78a8BEf57";
var account_two = "0xf17f52151EbEF6C7334FAD080c5704D77216b732";

Ethnote.deployed().then(function(instance) { meta = instance; return meta.getNotes(account_two); })

this.Ethnote.deployed().then(instance => { return instance.get_notebooks({from: this.account});}).then(result => {console.log(result);}).catch(e => {console.log(e);});