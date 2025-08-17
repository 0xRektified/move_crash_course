module net2dev_addr::tables_demo {
    use aptos_framework::table::{Self, Table};
    use std::signer;
    use std::string::String;

    struct Property has store, copy, drop {
        baths: u16,
        beds: u16,
        sqm: u16,
        phy_address: String,
        price: u64,
        available: bool,
    }

    struct PropList has key {
        info: Table<u64, Property>,
        prop_id: u64,
    }

    fun register_seller(account: &signer){
        let init_property = PropList {
            info: table::new(),
            prop_id: 0,
        };
        move_to(account, init_property);
    }

    fun list_property(account: &signer, prop_info: Property) acquires PropList {
        let account_addr = signer::address_of(account);
        assert!(exists<PropList>(account_addr) == true, 101);
        let prop_list = borrow_global_mut<PropList>(account_addr);
        let new_id = prop_list.prop_id + 1;
        table::upsert(&mut prop_list.info, new_id, prop_info);
        prop_list.prop_id = new_id;
    }

    fun read_property(account: signer, prop_id: u64)
    : (u16,u16,u16,String,u64, bool) acquires PropList{
        let account_addr = signer::address_of(&account);
        assert!(exists<PropList>(account_addr) == true , 101);
        let propt_list = borrow_global<PropList>(account_addr);
        let info = table::borrow(&propt_list.info, prop_id);
        (info.baths, info.beds, info.sqm, info.phy_address, info.price, info.available)
    }

    #[test_only]
    use std::debug::print;
    #[test_only]
    use std::string::utf8;

    #[test(account = @0x123)]
    fun test_fun(account: signer) acquires PropList{

        register_seller(&account);
        let prop_info = Property {
            baths: 2,
            beds: 4,
            sqm: 10,
            phy_address: utf8(b"test"),
            price: 100000,
            available: true,
        };
        list_property(&account, prop_info);
        let (baths, beds, sqm, phy_address, price, available) = read_property(account, 1);
        print(&baths);
        print(&beds);
        print(&sqm);
        print(&phy_address);
        print(&price);
        print(&available);

    }
}