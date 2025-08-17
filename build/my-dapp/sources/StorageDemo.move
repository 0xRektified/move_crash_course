module net2dev_addr::StorageDemo {
    use std::signer;

    struct StakePool has key, drop {
        amount: u64
    }

    fun add_user(account: &signer) {
        let amount: u64 = 0;
        move_to(account, StakePool {amount})
    }

    fun read_pool(account: address): u64 acquires StakePool {
        borrow_global<StakePool>(account).amount
    }

    fun stake(account:address, amount: u64) acquires StakePool {
        let entry = &mut borrow_global_mut<StakePool>(account).amount;
        *entry += amount;
    }

    fun unstake(account:address) acquires StakePool {
        let entry = &mut borrow_global_mut<StakePool>(account).amount;
        *entry = 0;
    }

    fun remove_user(account: &signer) acquires StakePool{
        move_from<StakePool>(signer::address_of(account));
    }

    fun confirm_user(account: address): bool {
        exists<StakePool>(account)
    }

    // #[test_only]
    // use std::string::utf8;
    // #[test_only]
    // use std::debug::print;

    // #[test(user = @0x123)]
    // fun test_fun(user: signer) acquires StakePool{
    //     add_user(&user);
    //     assert!(read_pool(signer::address_of(&user)) == 0, 1);
    //     print(&utf8(b"User added succesfully"));
    //     stake(signer::address_of(&user), 100);
    //     assert!(read_pool(signer::address_of(&user)) == 100, 1);
    //     print(&utf8(b"User got 100 token"));
    //     unstake(signer::address_of(&user));
    //     print(&utf8(b"Unstake"));
    //     remove_user(&user);
    //     assert!(confirm_user(signer::address_of(&user)) == false , 1);
    //     print(&utf8(b"User removed"));
    // }
}