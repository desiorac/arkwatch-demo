#!/usr/bin/env python3
"""ArkWatch Worker - Demo Version"""
import asyncio
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


async def main():
    logger.info("ArkWatch Worker started (demo mode)")
    logger.info("In production, this worker checks URLs at scheduled intervals")
    logger.info("For demo purposes, this is a placeholder")

    # Keep worker running
    while True:
        await asyncio.sleep(60)


if __name__ == "__main__":
    asyncio.run(main())
