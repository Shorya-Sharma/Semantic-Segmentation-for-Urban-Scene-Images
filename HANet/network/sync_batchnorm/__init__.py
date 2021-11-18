# -*- coding: utf-8 -*-
"""
# Code Adapted from:
# https://github.com/bmartacho/WASP
# MIT License.
"""

from .batchnorm import SynchronizedBatchNorm1d, SynchronizedBatchNorm2d, SynchronizedBatchNorm3d
from .replicate import DataParallelWithCallback, patch_replication_callback
