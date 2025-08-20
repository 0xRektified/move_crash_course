module net2dev_addr::Sample8 {

    const E_NOT_ENOUGHT: u64 = 0;

    const N2DR: u64 = 1;
    const APT: u64 = 2;
    const WETH: u64 = 3;

    const FEE: u16 = 50;
    const Pool1_n2dr: u64 = 312;
    const Pool1_usdt: u64 = 3201;
    const N2DR_name: vector<u8> = b"N2D Rewards";

    const Pool2_apt: u64 = 21500;
    const Pool2_usdt: u64 = 124700;
    const APT_name: vector<u8> = b"APT";

    const Pool3_weth: u64 = 1310;
    const Pool3_usdt: u64 = 2750;
    const WETH_name: vector<u8> = b"WETH";

    fun get_supply(coin_symbol: u64): (u64, u64, vector<u8>){
        if (coin_symbol == N2DR){
            (Pool1_usdt, Pool1_n2dr, N2DR_name)
        } else if (coin_symbol == APT){
            (Pool2_usdt, Pool2_apt, APT_name)
        } else {
            (Pool3_usdt, Pool3_weth, WETH_name)
        }
    }

    fun token_price(coin1: u64, coin2: u64): u64{
        assert!(coin1 > 0, E_NOT_ENOUGHT);
        assert!(coin2 > 0, E_NOT_ENOUGHT);
        return coin1 / coin2
    }

    fun calculate_swap(coin1: u64, coin2: u64, coin1_amount: u64):u64{
        assert!(Pool1_usdt > coin1_amount, E_NOT_ENOUGHT);
        let fee: u64 = coin1_amount * (FEE as u64) / 10000;
        let mix_supply: u64 = coin1 * coin2;
        let new_usdt: u64 = coin1 + coin1_amount;
        let new_n2dr: u64 = mix_supply / (new_usdt - fee);
        coin2 - new_n2dr
    }

    #[test_only]
    use std::debug::print;
    #[test_only]
    use std::string::utf8;

    #[test]
    fun test_swap(){
        let swap_amount = 495; //USDT
        let (pool1, pool2, name) = get_supply(N2DR);
        print(&utf8(b"Swap USDT for:"));
        print(&utf8(name));

        let price_before = token_price(pool1 ,pool2);
        print(&price_before);
        let receive = calculate_swap(pool1, pool2, swap_amount);
        print(&receive);

        let coin1_after = pool1 + swap_amount;
        let coin2_after = pool2 - receive;
        let price_after = token_price(coin1_after ,coin2_after);
        print(&price_after);
    }
}