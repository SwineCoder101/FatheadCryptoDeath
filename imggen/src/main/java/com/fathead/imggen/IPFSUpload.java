package com.fathead.imggen;

import io.ipfs.api.IPFS;
import io.ipfs.api.MerkleNode;
import io.ipfs.api.NamedStreamable;

import java.io.File;
import java.io.IOException;

public class IPFSUpload {

    public static String uploadToIPFS(String filepath) throws IOException {
        IPFS ipfs = new IPFS("/ip4/127.0.0.1/tcp/5001");
        ipfs.refs.local();
        NamedStreamable.FileWrapper file = new NamedStreamable.FileWrapper(new File(filepath));
        MerkleNode addResult = ipfs.add(file).get(0);
        return addResult.hash.toString();
    }
}
