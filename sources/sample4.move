module net2dev_addr::Sample4 {
    use std::string::{String, utf8};
    use std::debug::print;


    fun sample_for_loop(count: u64): u64{
        let value: u64 = 0;
        for (i in 0.. count){
            value += 1;
        };
        value
    }

    fun sample_while_loop(count: u64): u64
    {
        let value: u64 = 0;
        let i: u64 = 1;
        while (i <= count){
            value += 1;
            i += 1;
        };
        value
    }
  
    fun sample_loop(count: u64): u64{
        let value: u64 = 0;
        let i: u64 = 1;
        loop {
            value += 1;
            i += 1;
            if (i == count) break
        };
        value
    }

    fun sample_abort_error(value: String){
        if (value == utf8(b"net2dev")){
            print(&utf8(b"correct"))
        } else {
            print(&utf8(b"abort"));
            abort 123
        };
    }

    fun sample_assert_error(value: String){
        assert!(value == utf8(b"net2dev"), 123);
        print(&utf8(b"correct"))
    }

    #[test]
    fun test_for_loop(){
        let result = sample_for_loop(10);
        print(&result);
    }

    #[test]
    fun test_while_loop(){
        let result = sample_while_loop(10);
        print(&result);
    }

    #[test]
    fun test_loop(){
        let result = sample_loop(10);
        print(&result);
    }

    #[test]
    #[expected_failure]
    fun test_abort_error(){
        sample_abort_error(utf8(b"net22dev"));
    }

    #[test]
    fun test_assert_error(){
        sample_assert_error(utf8(b"net2dev"));
    }
}