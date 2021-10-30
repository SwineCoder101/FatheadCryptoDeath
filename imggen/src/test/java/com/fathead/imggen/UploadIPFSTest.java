package com.fathead.imggen;

import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.IOException;

public class UploadIPFSTest {

    @Test
    public void uploadToIPFS() throws IOException {
        IPFS ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");
        ipfs.refs.local();
        NamedStreamable.FileWrapper file = new NamedStreamable.FileWrapper(new File("C:\\dev\\on-chain-fathead\\img\\low-res-img.png"));
        MerkleNode addResult = ipfs.add(file).get(0);
        System.out.println(addResult.hash.toString());
    }
}
