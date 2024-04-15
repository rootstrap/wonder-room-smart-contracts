// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract DigitalTwinGuitars is ERC721URIStorage {
    uint256 private _tokenIdCounter;
    uint256 public lastMintedGuitarId;

    struct GuitarDetails {
        string name;
        string serialNumber;
        string brand;
        string manufacturerCountry;
        string year;
        string guitarType;
    }

    mapping(uint256 => GuitarDetails) public guitarDetails;

    constructor() ERC721("DigitalTwinGuitars", "DTG") {}

    event GuitarMinted(
        uint256 indexed tokenId,
        address indexed owner,
        string name,
        string serialNumber
    );

    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter;
    }

    function mintGuitar(
        address recipient,
        GuitarDetails memory details,
        string memory tokenURI
    ) public returns (uint256) {
        require(
            recipient != address(0),
            "Recipient address cannot be the zero address."
        );

        require(bytes(details.name).length > 0, "Guitar name cannot be empty.");
        require(
            bytes(details.serialNumber).length > 0,
            "Serial number cannot be empty."
        );
        require(bytes(details.brand).length > 0, "Brand cannot be empty.");
        require(
            bytes(details.manufacturerCountry).length > 0,
            "Country cannot be empty."
        );
        require(bytes(details.year).length > 0, "Year cannot be empty.");
        require(
            bytes(details.guitarType).length > 0,
            "Guitar type cannot be empty."
        );
        require(bytes(tokenURI).length > 0, "tokenURI cannot be empty.");

        uint256 newItemId = _tokenIdCounter;
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        guitarDetails[newItemId] = details;

        emit GuitarMinted(
            newItemId,
            recipient,
            details.name,
            details.serialNumber
        );
        _tokenIdCounter += 1;

        lastMintedGuitarId = newItemId;

        return newItemId;
    }

    function getTokenIdByOwner(
        address owner
    ) external view returns (uint256[] memory) {
        uint256[] memory result = new uint256[](balanceOf(owner));
        uint256 resultIndex = 0;

        for (uint256 tokenId = 0; tokenId < totalSupply(); tokenId++) {
            if (ownerOf(tokenId) == owner) {
                result[resultIndex] = tokenId;
                resultIndex++;
            }
        }

        return result;
    }

    function getLastMintedGuitarId() public view returns (uint256) {
        return lastMintedGuitarId;
    }
}
