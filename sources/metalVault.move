module net2dev_addr::metalVault {
    use std::string::{String, utf8};
    use std::simple_map::{SimpleMap,  Self};
    use std::debug::print;
    use std::signer;

    struct MetalReserves has store, copy, drop {
        g28: SimpleMap<String, u64>,
        g57: SimpleMap<String, u64>,
        g114: SimpleMap<String, u64>,
    }

    struct MetalVault has key, copy, drop {
        gold:MetalReserves,
        silver:MetalReserves,
    }

    fun init_client(account: &signer) {
        let metal_vault : SimpleMap<String, u64> = simple_map::create();
        simple_map::add(&mut metal_vault, utf8(b"UAE"), 0);
        simple_map::add(&mut metal_vault, utf8(b"MEX"), 0);
        simple_map::add(&mut metal_vault, utf8(b"COL"), 0);

        let init_balance = MetalReserves {
            g28: metal_vault,
            g57: metal_vault,
            g114: metal_vault,
        };

        let vault = MetalVault {
            gold: init_balance,
            silver: init_balance,
        };

        move_to(account, vault);
    }

    fun get_vault(account: address):(MetalReserves, MetalReserves) acquires MetalVault {
        (
            borrow_global<MetalVault>(account).gold ,
            borrow_global<MetalVault>(account).silver
        )
    }

    const GOLD:u64 = 0;
    const SILVER:u64 = 1;

    fun read_balances(asset_balance: SimpleMap<String, u64>, grams: String){
        print(&grams);
        print(&utf8(b"UAE"));
        print(simple_map::borrow(&mut asset_balance, &utf8(b"UAE")));
        print(&utf8(b"COL"));
        print(simple_map::borrow(&mut asset_balance, &utf8(b"COL")));
        print(&utf8(b"MEX"));
        print(simple_map::borrow(&mut asset_balance, &utf8(b"MEX")));
    }

    fun get_client_balance(account: address, asset: u64) acquires MetalVault {
        let (gold, silver) = get_vault(account);
        if (asset == GOLD) {
            read_balances(gold.g28, utf8(b"28 Grams"));
            read_balances(gold.g57, utf8(b"57 Grams"));
            read_balances(gold.g114, utf8(b"114 Grams"));
        } else {
            read_balances(silver.g28, utf8(b"28 Grams"));
            read_balances(silver.g57, utf8(b"57 Grams"));
            read_balances(silver.g114, utf8(b"114 Grams"));
        }
    }

    fun update_balances(
        metal: &mut MetalReserves,
        amount: u64,
        weight: u64,
        country:String
    ): bool{
        if (weight == 28) {
            let current = simple_map::borrow_mut(&mut metal.g28, &country);
            *current += amount;
            true
        } else if (weight == 57){
            let current = simple_map::borrow_mut(&mut metal.g57, &country);
            *current += amount;
            true
        } else if (weight == 114) {
            let current = simple_map::borrow_mut(&mut metal.g114, &country);
            *current += amount;
            true
        } else {
            false
        }
    }

    fun add_values(
            account: address,
            country: String,
            type: u64,
            amount: u64,
            weight: u64,
        ): bool acquires MetalVault{
        if (type == GOLD){
            let metal = &mut borrow_global_mut<MetalVault>(account).gold;
            update_balances(metal, amount, weight, country)
        } else if (type == SILVER){
            let metal = &mut borrow_global_mut<MetalVault>(account).gold;
            update_balances(metal, amount, weight, country)
        } else {
            false
        }
    }

    #[test(client1= @0x123)]
    fun fun_test(client1: signer) acquires MetalVault{
        init_client(&client1);
        assert!(exists<MetalVault>(signer::address_of(&client1)) == true, 1);
        get_client_balance(signer::address_of(&client1), GOLD);
        let res = add_values(signer::address_of(&client1), utf8(b"UAE"), GOLD, 100, 57);
        let res = add_values(signer::address_of(&client1), utf8(b"UAE"), GOLD, 5, 28);
        print(&res);
        print(&utf8(b"---------------"));
        get_client_balance(signer::address_of(&client1), GOLD);

    }

}