module net2dev_addr::Sample2 {

    const MY_ADDR: address = @net2dev_addr;

    fun confirm_value(number: u64): (bool, u64) {
        if (number > 0) {
            (true, 1)
        } else {
            (false, 0)
        }
    }
    // #[test_only]
    // use std::debug::print;

    // #[test]
    // fun test_fun(){
    //     let (result, nbr) = confirm_value(1);
    //     print(&MY_ADDR);
    //     print(&result);
    //     print(&nbr);
    // }
}