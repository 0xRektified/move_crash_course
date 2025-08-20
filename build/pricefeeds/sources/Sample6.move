module net2dev_addr::Sample6{

    fun bitwise_or(a: u64, b: u64): u64{
        return a|b
    }

    fun bitwise_and(a: u64, b: u64): u64{
        return a&b
    }

    fun bitwise_xor(a: u64, b: u64): u64{
        return a^b
    }

    const RIGHT: u64 = 0;
    const LEFT: u64 = 1;
    
    fun bitshift(a: u64, times: u8, operator: u64): u64{
        if (operator == RIGHT){
            a >> times
        } else {
            a << times
        }
    }

    // #[test_only]
    // use std::debug::print;

    // #[test]
    // fun test_or(){
    //     let re =bitwise_or(7, 4);
    //     print(&re);
    // }

    // #[test]
    // fun test_and(){
    //     let re =bitwise_and(7, 4);
    //     print(&re);
    // }

    // #[test]
    // fun test_xor(){
    //     let re =bitwise_xor(7, 4);
    //     print(&re);
    // }

    // #[test]
    // fun test_bitshift(){
    //     let re = bitshift(7, 2, RIGHT);
    //     print(&re);
    //     let re = bitshift(7, 2, LEFT);
    //     print(&re);
    // }

}
