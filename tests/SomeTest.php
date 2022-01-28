<?php

declare(strict_types=1);

namespace App\Tests;

use PHPUnit\Framework\TestCase;

class SomeTest extends TestCase
{
    public function testHasAttribute(): void
    {
        self::assertSame(1, 1);
    }
}
