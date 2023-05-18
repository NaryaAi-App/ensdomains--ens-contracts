import {ENSRegistry} from "../../contracts/registry/ENSRegistry.sol";
import {DNSRegistrar} from "../../contracts/dnsregistrar/DNSRegistrar.sol";
import {TLDPublicSuffixList} from "../../contracts/dnsregistrar/TLDPublicSuffixList.sol";
import {OffchainDNSResolver} from "../../contracts/dnsregistrar/OffchainDNSResolver.sol";
import {DNSSECImpl} from "../../contracts/dnssec-oracle/DNSSECImpl.sol";

import "../../lib/narya-contracts/PTest.sol";

contract Base is PTest {
    ENSRegistry public registry;
    DNSSECImpl oracle;
    OffchainDNSResolver offchainDNSResolver;
    TLDPublicSuffixList publicSuffixList;
    DNSRegistrar registrar;

    address owner;

    function setUp() public {
        owner = makeAddr("Owner");

        vm.startPrank(owner);

        registry = new ENSRegistry();

        bytes memory anchors;
        oracle = new DNSSECImpl(anchors);

        offchainDNSResolver = new OffchainDNSResolver(
            registry,
            oracle,
            "https://dnssec-oracle.ens.domains/"
        );

        publicSuffixList = new TLDPublicSuffixList();

        registrar = new DNSRegistrar(
            address(0),
            address(offchainDNSResolver),
            oracle,
            publicSuffixList,
            registry
        );

        vm.stopPrank();
    }

    function testme() public {
        assert(false);
    }
}
