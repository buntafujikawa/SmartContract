pragma solidity ^0.4.11;
contract CrowdFunding {
    // 投資家
    struct Investor {
        address addr;
        uint amount;
    }

    address public owner;
    uint public numInvestors;
    uint public deadline;
    string public status;
    bool public ended;
    uint public goalAmount;
    uint public totalAmount
    mapping (uint => Investor) public investors; // keyがuint型でvalueがInvestor型

    // modifierを実装して関数に付与すると、呼び出し前にmodifierの処理が実行される
    modifier onlyOwner() {
        // 条件に満たなかった場合(falseになった場合)throwされ処理が中断される
        require(msg.sender == owner);
        _;
    }

    // コンストラクタ
    function CrowdFunding(uint _duration, uint _goalAmount) {
        owner = msg.sender;

        deadline = now + _duration;

        goalAmount = _goalAmount;
        status = "Funding";
        ended = false;

        numInvestors = 0;
        totalAmount = 0;
    }

    // 投資する際に呼出される関数
    function fund() payable {
        // キャンペーンが終わっていれば処理を中断する
        require(!ended);

        Investor inv = investors[numInvestors++];
        inv.addr = msg.sender;
        inv.amount = msg.value;
        totalAmount += inv.amount;
    }

    // 目標額に達したかを確認
    // キャンペーンの成功/失敗に応じたetherの送金
    function checkGoalReached () public onlyOwner {
        require(!ended)

        require(now >= deadline)

        if(totalAmount >= goalAmount) { // キャンペーンに成功した場合
            status = "Campaign Succeeded"
            ended = true;

            // オーナーにコントラクトないのすべてのetherを送金する
            if(!owner.send(this.balance)) { // balanceは予約語で、addressの残高が取得できる
                throw;
            }]
        } else { // キャンペーンに失敗した場合
            uint i = 0;
            status = "Campaign Failed";
            ended = true;

            // 投資家ごとにetherを返金する
            while(i <= numInvestors) {
                if(!investors[i].addr.send(investors[i].amount)) {
                    throw;
                }
                i++;
            }
        }
    }

    // コンストラクタを破棄するための関数
    function kill() public onlyOwner {
        selfdestruct(owner);
    }
}
