pragma solidity ^0.4.11; // コンパイラバージョン指定
contract HelloEthereum {
    string public msg1;

    string private msg2;

    address public owner;

    uint8 public counter;

    // スマートコントラクトの生成時に実行される
    function HelloEthereum(string _msg1) {
        msg1 = _msg1;

        ownere = msg.sender;

        counter = 0;
    }

    function setMsg(string _msg2) public {
        if(ownere != msg.sender) {
            throw;
        } else {
            msg2 = _msg2;
        }
    }

    // constantはコール専用、returnsで戻り値の型を宣言
    function getMsg2() constant public returns(string) {
        return msg2;
    }

    function setCounter() public {
        for(uint8 i = 0; i < 3; i++) {
            counter++;
        }
    }
}

