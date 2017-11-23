pragma solidity ^0.4.11;
contract NameRegistry {

    struct Contract {
        address owner;
        address addr;
        bytes32 description;
    }

    // 登録済みのレコード数
    uint public numContracts;

    コントラクトを保持するマップ
    mapping (bytes32 => Contract) public contracts;

    function NameRegistry() {
        numContracts = 0;
    }

    // コントラクトを登録する
    function register(bytes32 _name) public returns (bool) {
        // 名前が利用されていなければ登録をする
        if (contracts[_name].owner == 0) {
            Contract con = contracts[_name];
            con.owner = msg.sender;
            numContracts++;
            return true;
        } else {
            return false;
        }
    }

    // コントラクトを削除する
    function unregister(bytes32 _name) public returns (bool) {
        if (contracts[_name].owner == msg.sender) {
            contracts[_name].owner = 0;
            numContracts--;
            return true;
        } else {
            return false;
        }
    }

    // コントラクトのオーナーを変更する
    function changeOwner(bytes32 _name, address _newOwner) public onlyOwner(_name) {
        contracts[_name].owner = _newOwner;
    }

    // コントラクトのオーナーを取得する
    function getOwner(bytes32 _name) constant public returns (address) {
        return contracts[_name].owner;
    }

    // コンストラクトのアドレスをセットする
    function setAddr(bytes32 _name, address _addr) public onlyOwner(_name) {
        contracts[_name].addr = _addr;
    }

    // コンストラクトのアドレスを取得する
    function getAddr(bytes32 _name) constant public returns (address) {
        return contracts[_name].addr;
    }

    // コンストラクトの説明を設定する
    function setDescription(bytes32 _name, bytes32 _description) public onlyOwner(_name) {
        contracts[_name].description = _description;
    }

    // コンストラクトの説明を取得する
    function getDescription(bytes32 _name) constant public returns (bytes32) {
        return contracts[_name].description;
    }

    modifier onlyOwner(bytes32 _name) {
        require(contracts[_name].owner == msg.sender);
        _;
    }
}
