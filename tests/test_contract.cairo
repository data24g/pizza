#[cfg(test)]
mod tests {
    use snforge_std::{
        ContractClassTrait, declare, test_address,
    };
    use starknet::ContractAddress;
    use test::{ //use tới tên của package tìm trong scarb.toml
        IPizzaFactoryDispatcher, IPizzaFactoryDispatcherTrait,
        PizzaFactory // Thêm dòng này để truy cập event
    };

    fn setup_contract(){
        let contract_class = declare("PizzaFactory"); // tên modun lấy từ lib.cairo
        let owner = test_address();
        let contract = declare("PizzaFactory").unwrap();
        let contract_address = contract.deploy(@array![owner]).unwrap();
        let dispatcher = IPizzaFactoryDispatcher { contract_address };
    }
    #[test]
    fn make_pizza() {
        let dispatcher = setup_contract();
    }
}
