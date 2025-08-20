module net2dev_addr::RefDemo {
    use std::debug::print;

    // Non-Ref tpye to immuatable Ref
    fun scenario_1(){
        let value_a = 10;
        let im_ref: &u64 = &value_a;
        print(im_ref)
    }

    fun scenario_2(){
        let value_a = 10;
        let mut_ref: &mut u64 = &mut value_a;
        let im_ref: &u64 = mut_ref;
        print(im_ref)
    }

    fun re_assign(value_a: &mut u64, value_b: &u64){
        *value_a = *value_b;
        print(value_a)
    }

    fun scenario_3(){
        let value_a: &mut u64 = &mut 10;
        let value_b: &u64 = &20;
        re_assign(value_a,value_b);
    }

    #[test]
    fun test_fuf(){
        scenario_1();
        scenario_2();
        scenario_3();
    }
}