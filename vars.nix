{
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUgE09xB2WSFpuow24yGsgPoLaEVMFfYC+/S5p+mS69 k@k-lg-gram"
  ];

  dns = {
    email = "fllstck@pm.me";
    provider = "vercel";
    credentialFile = "/root/vercel-token";
  };

  environment = {
    ARNS_ROOT_HOST = "arweave.developerdao.com";
    ADMIN_API_KEY = "permaframes123";
    AR_IO_WALLET = "Cn79LdBT7Qcno4W5JXkXCfq4wa54SRHtKVjYV4Me3NbJ";
    RUN_OBSERVER = "false";
    CONTIGUOUS_DATA_CACHE_CLEANUP_THRESHOLD = "86400";
    ENABLE_FS_HEADER_CACHE_CLEANUP = "true";
    ENABLE_DATA_DB_WAL_CLEANUP = "true";
  };
}
