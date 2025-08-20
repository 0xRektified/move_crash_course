module net2dev_addr::SignerDemo{
    use std::signer;
    use std::debug::print;
    use std::string::{String, utf8};

    const NOT_OWNER: u64 = 0;
    const OWNER: address = @net2dev_addr;

    fun check_owner(account: signer) {
        let address_val: &address = signer::borrow_address(&account);
        assert!(signer::address_of(&account) == OWNER, NOT_OWNER);
        // print(&signer::address_of(&account));
        print(address_val);
    }

    // // #[test(account = @0x123)] //Wrong
    // #[test(account = @net2dev_addr)]
    // fun test_function(account: signer){
    //     check_owner(account);
    // }
}