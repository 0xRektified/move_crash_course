module net2dev_addr::price_feeds{
    use std::vector;
    use std::string::{String, utf8};
    use std::timestamp;
    use std::signer;

    struct TokenFeed has store, drop, copy {
        last_price: u64,
        timestamp: u64,
    }

    struct PriceFeeds has key, store, drop, copy {
        symbols: vector<String>,
        data: vector<TokenFeed>,
    }

    const ENOT_OWNER: u64 = 101;

    fun init_module(owner: &signer){
        let symbols = vector::empty<String>();
        symbols.push_back(utf8(b"BTC"));
        let new_feed = TokenFeed{
            last_price: 0,
            timestamp: 0,
        };
        let data_feed = PriceFeeds{
            symbols,
            data: vector[new_feed]
        };
        move_to(owner, data_feed)
    }

    public entry fun update_feed(owner: &signer, last_price: u64, symbol: String)
     acquires PriceFeeds{
        let signer_addr = signer::address_of(owner);
        assert!(signer_addr == @net2dev_addr, ENOT_OWNER);
        let time = timestamp::now_seconds();
        let data_store = borrow_global_mut<PriceFeeds>(signer_addr);
        let new_feed = TokenFeed{
            last_price,
            timestamp: time,
        };
        let (result, i) = data_store.symbols.index_of(&symbol);
        if (result){
            data_store.data.replace(i, new_feed);
        } else {
            data_store.symbols.push_back(symbol);
            data_store.data.push_back(new_feed);
        }
    }

    #[view]
    public fun get_token_price(symbol: String): TokenFeed acquires PriceFeeds {
        let symbols = borrow_global<PriceFeeds>(@net2dev_addr).symbols;
        let (result, i) = symbols.index_of(&symbol);
        if (result){
            let data_feed = borrow_global<PriceFeeds>(@net2dev_addr).data;
            *data_feed.borrow(i)
        } else {
            TokenFeed{
                last_price: 0,
                timestamp: 0
            }
        }
    }

    #[test_only]
    use std::debug::print;

    #[test(owner=@net2dev_addr, init_addr= @0x1)]
    fun test_fun(owner: &signer, init_addr: signer) acquires PriceFeeds{
        timestamp::set_time_has_started_for_testing(&init_addr);
        init_module(owner);
        update_feed(owner, 110000, utf8(b"BTC"));
        let result = get_token_price(utf8(b"BTC"));
        print(&result);
    }
}